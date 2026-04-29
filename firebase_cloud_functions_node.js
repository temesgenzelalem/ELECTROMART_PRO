const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// 1. Process Payment & Finalize Order
exports.processOrder = functions.firestore
    .document('orders/{orderId}')
    .onCreate(async (snap, context) => {
        const order = snap.data();
        // Trigger payment gateway (Stripe/Razorpay)
        // Send confirmation email
        // Update product inventory
        const batch = admin.firestore().batch();
        order.items.forEach(item => {
            const productRef = admin.firestore().collection('products').doc(item.productId);
            batch.update(productRef, { stock: admin.firestore.FieldValue.increment(-item.quantity) });
        });
        return batch.commit();
    });

// 2. Price Drop Notifications
exports.onProductPriceUpdate = functions.firestore
    .document('products/{productId}')
    .onUpdate(async (change, context) => {
        const newValue = change.after.data();
        const previousValue = change.before.data();
        if (newValue.price < previousValue.price) {
            // Find users with this product in wishlist
            const wishlists = await admin.firestore().collection('wishlists')
                .where('products', 'array-contains', context.params.productId).get();
            // Send FCM to each user
        }
    });

// 3. Abandoned Cart Reminder (Scheduled)
exports.abandonedCartReminder = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
    // Query carts not updated in 24 hours
    // Send FCM reminder
});
