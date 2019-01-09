class FailuresController < ApplicationController
  before_action :require_admin
  layout "admin"

  helper :sort
  include SortHelper

  def index
    sort_init "id", "desc"
    sort_update %w(id name created_at path)

    scope = Failure.not_acknowledged

    @limit = per_page_option
    @failure_count = scope.count
    @failure_pages = Paginator.new @failure_count, @limit, params[:page]
    @offset ||= @failure_pages.offset
    @failures =  scope.order(sort_clause).limit(@limit).offset(@offset)

    render :layout => !request.xhr?
  end

  def show
    @failure = Failure.find(params[:id].to_i)
  end

  def update
    @failure = Failure.find(params[:id].to_i)
    @failure.acknowledge! if params[:acknowledged] == "1"
    @failure.acknowledge_similar_failures if params[:acknowledged] == "similar"
    @failure.acknowledge_all_failures if params[:acknowledged] == "all"
    redirect_to failures_path
  end
end
