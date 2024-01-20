import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lesson-history"
export default class extends Controller {

  static targets = ["readTime", "enrollment", "lesson", "viewedLesson"]

  readTime = 0;
  enrollment = null;
  lesson = null;
  storeLessonHistoryTimer = null;
  viewedLesson = false;

  connect() {
    console.log("Connected to Lesson History")

    if (this.readTimeTarget)
      this.readTime = parseFloat(this.readTimeTarget.value);
    if (this.enrollmentTarget)
      this.enrollment = parseInt(this.enrollmentTarget.value);
    if (this.lessonTarget)
      this.lesson = parseInt(this.lessonTarget.value);
    if (this.viewedLessonTarget)
      this.viewedLesson = this.viewedLessonTarget.value === "true";

    if (this.readTime && this.viewedLesson === false) {
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

        if (data && data.message === "Lesson History Saved!") {
          clearTimeout(this.storeLessonHistoryTimer);

          this.viewedLesson = true;
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
