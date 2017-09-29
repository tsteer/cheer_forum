# field_with_errors throws off alyout when new user form has an error.
# This removes the filed_with_errors wrapper
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
