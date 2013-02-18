class FailuresController < ApplicationController
  before_filter :require_admin
  layout "admin"

  helper :sort
  include SortHelper

  def index
    sort_init "id", "desc"
    sort_update %w(id name created_at)

    scope = Failure

    @limit = per_page_option
    @failure_count = scope.count
    @failure_pages = Paginator.new self, @failure_count, @limit, params[:page]
    @offset ||= @failure_pages.current.offset
    @failures =  scope.order(sort_clause).limit(@limit).offset(@offset)

    render :layout => !request.xhr?
  end
end
