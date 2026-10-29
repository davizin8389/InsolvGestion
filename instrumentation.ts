export async function register() {
  if (process.env.NEXT_RUNTIME !== "nodejs" || process.env.RUN_REMINDER_SCHEDULER !== "true") return;
  const worker = await import("@/lib/reminder-worker");
  worker.startReminderWorker();
}
