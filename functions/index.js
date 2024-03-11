const {onSchedule} = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");

admin.initializeApp();

exports.dailyReminderNotifications = onSchedule("every day 07:00", async () => {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const usersSnapshot = await admin.firestore().collection("users").get();
  const reminderPromises = [];

  usersSnapshot.forEach((userDoc) => {
    const remindersSnapshotPromise = userDoc.ref.collection("reminders")
        .get().then((remindersSnapshot) => {
          remindersSnapshot.forEach((reminderDoc) => {
            const reminder = reminderDoc.data();
            const reminderDate = reminder.reminderDate.toDate();
            reminderDate.setHours(0, 0, 0, 0);
            if (reminderDate.getTime() === today.getTime() &&
            reminder.fcmToken) {
              return sendPushNotification(reminder);
            }
          });
        });

    reminderPromises.push(remindersSnapshotPromise);
  });

  await Promise.all(reminderPromises);
  console.log("Revisión diaria de recordatorios" +
  "para envío de notificaciones completada.");
});

/**
 * Envía una notificación push a un dispositivo específico.
 * @param {Object} reminder - El recordatorio.
*/
async function sendPushNotification(reminder) {
  const message = {
    token: reminder.fcmToken,
    notification: {
      title: reminder.title,
      body: reminder.description,
    },
    data: {
      id: reminder.id,
      category: reminder.category,
      petId: reminder.petId,
    },
  };

  try {
    await admin.messaging().send(message);
    console.log("Notificación enviada con éxito.");
  } catch (error) {
    console.error("Error al enviar la notificación:", error);
  }
}
