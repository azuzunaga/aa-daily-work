# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {username: 'user1'},
  {username: 'user2'},
  {username: 'user3'}])

Poll.create!([
  {user_id: 1, title: 'title1'},
  {user_id: 2, title: 'title2'},
  {user_id: 3, title: 'title3'},
  {user_id: 1, title: 'title4'}])

Question.create!([
  {poll_id: 1, text: "text1"},
  {poll_id: 2, text: "text2"},
  {poll_id: 3, text: "text3"},
  {poll_id: 1, text: "text4"},
  {poll_id: 1, text: "text5"},
  {poll_id: 2, text: "text6"}
  ])

AnswerChoice.create!([
  {question_id: 1, text: "answer1"},
  {question_id: 2, text: "answer2"},
  {question_id: 3, text: "answer3"},
  {question_id: 4, text: "answer4"},
  {question_id: 5, text: "answer5"},
  {question_id: 6, text: "answer6"},
  {question_id: 1, text: "answer7"},
  {question_id: 1, text: "answer8"},
  {question_id: 2, text: "answer9"}
  ])

Response.create!([
  {user_id: 1, question_id: 1, answer_choice_id: 1},
  {user_id: 2, question_id: 2, answer_choice_id: 2},
  {user_id: 3, question_id: 3, answer_choice_id: 3},
  {user_id: 1, question_id: 4, answer_choice_id: 4},
  {user_id: 2, question_id: 5, answer_choice_id: 5},
  {user_id: 3, question_id: 6, answer_choice_id: 6},
  {user_id: 2, question_id: 1, answer_choice_id: 7},
  {user_id: 3, question_id: 2, answer_choice_id: 8}
  ])
