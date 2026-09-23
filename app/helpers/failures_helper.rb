module FailuresHelper
  def failure_request(failure, truncate: true)
    return if failure.path.blank?

    label = truncate ? truncate(failure.path) : failure.path
    # Following a non-GET URL would issue a GET, so only link replayable requests
    url = failure.http_method.blank? || failure.http_method == "GET" ? link_to(label, failure.path) : label
    method = content_tag(:span, failure.http_method, class: "http-method") if failure.http_method.present?
    safe_join([method, url].compact, " ")
  end
end
