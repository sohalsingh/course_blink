import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener('turbo:load', () => {
      const quizFrame = document.getElementById('quiz_frame');
      const requestFullscreen = quizFrame.requestFullscreen || quizFrame.mozRequestFullScreen || quizFrame.webkitRequestFullscreen || quizFrame.msRequestFullscreen;

      if (requestFullscreen && !document.fullscreenElement && quizFrame) {
        // wait for the quiz frame to load
        console.log('requesting fullscreen');
        document.addEventListener('click', () => {
          requestFullscreen.call(quizFrame);
        }, { once: true });
      }

      const quizForms = document.querySelectorAll('.quiz-form');
      quizForms.forEach((form) => {
        form.addEventListener('submit', (event) => {
          event.preventDefault();
          const questionId = form.dataset.questionId;
          const selectedOptionId = form.querySelector('input[name="option"]:checked').value;

          // Send an AJAX request to create the submission
          // Example:
          // fetch('/submissions', {
          //   method: 'POST',
          //   headers: {
          //     'Content-Type': 'application/json',
          //     'X-CSRF-Token': '<%= form_authenticity_token %>'
          //   },
          //   body: JSON.stringify({
          //     question_id: questionId,
          //     option_id: selectedOptionId
          //   })
          // })
          // .then(response => response.json())
          // .then(data => {
          //   // Handle the response
          // });

          // Move to the next question slide
          const currentSlide = form.closest('.question-slide');
          const nextSlide = currentSlide.nextElementSibling;
          currentSlide.classList.remove('active');
          // Check if it's the last question
          if (!nextSlide) {
            // Submit the form again
            console.log('Submitting the form again');
            this.handleSubmit();
            return;
          }
          nextSlide.classList.add('active');

        });

        const previousButtons = form.querySelectorAll('.previous-question');
        previousButtons.forEach((button) => {
          button.addEventListener('click', (event) => {
            event.preventDefault();
            const currentSlide = form.closest('.question-slide');
            const previousSlide = currentSlide.previousElementSibling;
            currentSlide.classList.remove('active');
            previousSlide.classList.add('active');
          });
        });
      });

      document.addEventListener('fullscreenchange', () => {
        if (!document.fullscreenElement) {
          // Full screen exited
          console.log('Full screen exited');
          // Add your code here to handle the event
        }
      });
    });
  }

  handleSubmit() {
    const url = `/api/v1/submissions`;
    const redirectUrl = document.querySelector('#course_lessons_url').value;

    // get all submissions from the form
    const currentUserId = parseInt(document.querySelector('#current_user_id').value);
    const submissions = this.element.querySelectorAll('.quiz-form');
    const submissionData = [];
    submissions.forEach((submission) => {
      const questionId = submission.dataset.questionId;
      const selectedOptionId = submission.querySelector('input[name="option"]:checked').value;
      submissionData.push({
        question_id: questionId,
        option_id: selectedOptionId,
        user_id: currentUserId
      });
    });

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({
        submissions: submissionData
      })
    })
      .then(response => response.json())
      .then(data => {

        if (data && data.message === "Submissions Saved!") {
          window.location.href = redirectUrl;
        }
      })
      .catch(error => {
        console.error("Error generating invoice number:", error);
      });

  }
}
