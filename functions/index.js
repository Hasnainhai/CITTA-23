const functions = require("firebase-functions");
const stripe = require("stripe")(
    "secerat key here",
);

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
  try {
    let customerId;

    // Gets the customer who's email id matches the one sent by the client
    const customerList = await stripe.customers.list({
      email: req.body.email,
      limit: 1,
    });

    // Checks the if the customer exists, if not creates a new customer
    if (customerList.data.length !== 0) {
      customerId = customerList.data[0].id;
    } else {
      const customer = await stripe.customers.create({
        name: "Jenny Rosen",
        address: {
          line1: "510 Townsend St",
          postal_code: "98140",
          city: "San Francisco",
          state: "CA",
          country: "US",
        },
      });
      customerId = customer.data.id;
    }

    // Creates a temporary secret key linked with the customer
    const ephemeralKey = await stripe.ephemeralKeys.create(
        {customer: customerId},
        {apiVersion: "2023-10-16"},
    );

    // Creates a new payment intent with amount passed in from the client
    const paymentIntent = await stripe.paymentIntents.create({
      description: "Software development services",
      shipping: {
        name: "Jenny Rosen",
        address: {
          line1: "510 Townsend St",
          postal_code: "98140",
          city: "San Francisco",
          state: "CA",
          country: "US",
        },
      },
      amount: parseInt(req.body.amount),
      currency: "usd",
      payment_method_types: ["card"],
    });

    res.status(200).send({
      paymentIntent: paymentIntent.client_secret,
      ephemeralKey: ephemeralKey.secret,
      customer: customerId,
      success: true,
    });
  } catch (error) {
    res.status(404).send({success: false, error: error.message});
  }
});
