import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lesson-history"
export default class extends Controller {

  static targets = ["readTime", "enrollment", "lesson"]

  readTime = 0;
  enrollment = null;
  lesson = null;
  storeLessonHistoryTimer = null;

  connect() {
    console.log("Connected to Lesson History")

    if (this.readTimeTarget)
      this.readTime = parseFloat(this.readTimeTarget.value);
    if (this.enrollmentTarget)
      this.enrollment = parseInt(this.enrollmentTarget.value);
    if (this.lessonTarget)
      this.lesson = parseInt(this.lessonTarget.value);

    if (this.readTime) {
      const milliseconds = this.readTime * 60 * 1000;
      this.storeLessonHistoryTimer = setTimeout(() => {
        this.storeLessonHistory();
      }, milliseconds);

    }

  }

  storeLessonHistory() {
    const url = `/api/v1/lesson_history`;
    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({
        enrollment_id: this.enrollment,
        lesson_id: this.lesson,
      })
    })
      .then(response => response.json())
      .then(data => {
        console.log("API Response:", data);

        if (data) {
          clearTimeout(this.storeLessonHistoryTimer);
        }
      })
      .catch(error => {
        console.error("Error generating invoice number:", error);
      });
  }

  disconnect() {
    clearTimeout(this.storeLessonHistoryTimer);
  }

}
