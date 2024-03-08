// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");
const {schedule} = require("firebase-functions/v2");
const admin = require("firebase-admin");

admin.initializeApp();

exports.scheduleWeeklyReminders = schedule("every monday 05:00").timeZone("UTC")
    .onRun(async (context) =>{
      const startOfWeek = getStartOfWeek();
      const endOfWeek = getEndOfWeek();
      const usersSnapshot = await admin.firestore().collection("users").get();

      for (const userDoc of usersSnapshot.docs) {
        const remindersSnapshot = await userDoc.ref
            .collection("reminders").get();
        for (const reminderDoc of remindersSnapshot.docs) {
          const reminder = reminderDoc.data();
          const reminderDate = parseReminderDate(reminder.reminderDate);

          if (reminderDate >= startOfWeek && reminderDate < endOfWeek) {
            const notificationTime = new Date(reminderDate);
            notificationTime.setHours(7, 0, 0);

            console.log(`Programando notificación para 
            ${userDoc.id} en ${notificationTime}`);
          }
        }
      }
      console.log("Revisión de recordatorios semanal completada.");
    });

/**
 * Calcula el inicio de la semana actual.
 *
 * @return {Date} El inicio de la semana (lunes a las 00:00:00 horas).
 */
function getStartOfWeek() {
  const now = new Date();
  const dayOffset = now.getDay() === 0 ? -6 : 1;
  const startOfWeek = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate() - now.getDay() + dayOffset,
  );
  startOfWeek.setHours(0, 0, 0, 0);
  return startOfWeek;
}

/**
 * Calcula el final de la semana actual.
 *
 * @return {Date} El final de la semana (domingo a las 23:59:59 horas).
 */
function getEndOfWeek() {
  const now = new Date();
  const dayAdjustment = 7 - now.getDay();
  const endOfWeek = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate() + dayAdjustment,
  );
  endOfWeek.setHours(23, 59, 59, 999);
  return endOfWeek;
}

/**
 * Convierte una cadena de fecha en el formato "dd-MM-yyyy" a un objeto Date.
 *
 * @param {string} dateString - La cadena de fecha en el formato "dd-MM-yyyy".
 * @return {Date} La fecha convertida como objeto Date.
 */
function parseReminderDate(dateString) {
  const dateParts = dateString.split("-").map((num) => parseInt(num, 10));
  const [day, month, year] = dateParts;
  return new Date(year, month - 1, day, 7);
  // Ajuste para que todos los recordatorios sean a las 7 AM
}
