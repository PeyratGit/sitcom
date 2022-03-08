if @feedback.persisted?
  json.form json.partial!("feedbacks/form.html.erb", tv_show: @tv_show, feedback: @feedback)
  json.inserted_item json.partial!("tv_shows/feedback.html.erb", feedback: @feedback)
else
  json.form json.partial!("feedbacks/form.html.erb", tv_show: @tv_show, feedback: @feedback)
end
