# Failures access
class FailuresController < ApplicationController
  before_action :require_admin
  layout 'admin'

  helper :sort
  include SortHelper

  def index
    sort_init 'id', 'desc'
    sort_update %w[id name created_at path]

    scope = Failure.not_acknowledged

    @limit = per_page_option
    @failure_count = scope.count
    @failure_pages = Paginator.new @failure_count, @limit, params[:page]
    @offset ||= @failure_pages.offset
    @failures = scope.order(sort_clause).limit(@limit).offset(@offset)

    render layout: !request.xhr?
  end

  def show
    @failure = Failure.find(params[:id].to_i)
  end

  def update
    @failure = Failure.find(params[:id].to_i)
    case params[:acknowledged]
    when '1'
      @failure.acknowledge!
    when 'similar'
      @failure.acknowledge_similar_failures
    when 'all'
      @failure.acknowledge_all_failures
    else
      Rails.logger.warn("redmine_uhoh: Unknown acknowledge mode: \"#{params[:acknowledged]}\"")
    end
    redirect_to failures_path
  end
end
