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

ActiveRecord::Schema.define(version: 20160902215053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "matches", force: true do |t|
    t.integer  "story_one_id"
    t.integer  "story_two_id"
    t.integer  "human_review"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "algorithm_review"
  end

  create_table "newspapers", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "main_rss_feed_url"
    t.integer  "circulation"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "published"
    t.text     "summary"
    t.integer  "newspaper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "parsed_date"
  end

  create_table "word_stats", force: true do |t|
    t.string   "name"
    t.float    "one_month_frequency"
    t.float    "one_week_frequency"
    t.float    "one_day_frequency"
    t.float    "half_day_frequency"
    t.float    "quarter_day_frequency"
    t.float    "one_hour_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "all_time_count"
  end

  create_table "words", force: true do |t|
    t.string   "name"
    t.integer  "story_id"
    t.datetime "story_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
