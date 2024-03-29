// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CourseQuizController from "./course_quiz_controller"
application.register("course-quiz", CourseQuizController)

import GoogleSearchController from "./google_search_controller"
application.register("google-search", GoogleSearchController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import LessonHistoryController from "./lesson_history_controller"
application.register("lesson-history", LessonHistoryController)

import SearchController from "./search_controller"
application.register("search", SearchController)
