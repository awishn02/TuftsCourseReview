# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140414132249) do

  create_table "course_scores", force: true do |t|
    t.integer  "professor_id"
    t.integer  "course_id"
    t.integer  "semester_id"
    t.decimal  "score",         precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_reviews"
    t.integer  "department_id"
    t.integer  "total_enrollment"
  end

  create_table "courses", force: true do |t|
    t.integer  "department_id"
    t.string   "course_num"
    t.string   "name"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dep_code"
    t.boolean  "opt_out",    default: true
  end

  create_table "evaluations", force: true do |t|
    t.integer  "course_id"
    t.integer  "professor_id"
    t.decimal  "course_score",  precision: 5, scale: 2
    t.decimal  "teacher_score", precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
    t.integer  "total_reviews"
  end

  create_table "professor_scores", force: true do |t|
    t.integer  "professor_id"
    t.integer  "course_id"
    t.integer  "semester_id"
    t.decimal  "score",         precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_reviews"
    t.integer  "department_id"
    t.integer  "total_enrollment"
  end

  create_table "professors", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "opt_out",       default: false
    t.string   "utln"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semesters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
