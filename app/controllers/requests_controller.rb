class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy calendar]

  def index
    @requests_all = policy_scope(Request)
    @exchanges = Exchange.where(status: "Pendente")
    @requests = @requests_all.where.missing(:exchange).order(created_at: :desc)

    if params[:start_time].present? || params[:end_time].present?
      start_time = params[:start_time].blank? ? Date.new(1980, 1, 1) : Time.zone.parse(params[:start_time]).beginning_of_day
      end_time = params[:end_time].blank? ? Date.new(2040, 1, 1) : Time.zone.parse(params[:end_time]).end_of_day

      @requests = @requests.where(start_time: start_time..end_time, end_time: start_time..end_time)
    end

    # if params[:start_time].present? || params[:end_time].present?
    #   start_time = params[:start_time].blank? ? Date.new(1980, 1, 1)..Date.new(2040, 1, 1) : (Time.zone.parse(params[:start_time]).beginning_of_day)..(Time.zone.parse(params[:start_time]).beginning_of_day + 1.day)
    #   end_time = params[:end_time].blank? ? Date.new(1980, 1, 1)..Date.new(2040, 1, 1) : (Time.zone.parse(params[:end_time]).end_of_day - 1.day)..(Time.zone.parse(params[:end_time]).end_of_day)

    #   @requests = @requests.where(start_time: start_time, end_time: end_time)
    # end

    if params[:origin].present?
      @requests = @requests.where("origin ILIKE ?", "%#{params[:origin]}%")
    end

    if params[:destination].present?
      @requests = @requests.where("destination ILIKE ?", "%#{params[:destination]}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "mycalendar", locals: { request: @request }, formats: [:html] }
    end
  end

  def search
    start_time = params[:start_time] || DateTime.now
    end_time = params[:end_time] || DateTime.now
    origin = params[:origin]
    destination = params[:destination]
    @requests = Request.search(start_time, end_time, origin, destination)
  end

  def show
    @exchanges = @request.exchange
    @exchange = Exchange.new
  end

  def new
    @request = Request.new
    authorize @request
  end

  def update
    authorize @request
    if @request.update(request_params)
      redirect_to requests_path, notice: "Sua solicitação foi alterada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_path, status: :see_other, notice: "Sua solicitação foi excluída."
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user

    # se usuario criou request com mesma origem block
    # if @request.user.includes() ja tem @request mesmo origem

    # se usuario criou request com mesmo data block

    # se usuario criou request com mesmo horario block


    authorize @request
    range = params[:request][:start_time].split(' to ')
    @request.start_time = range.first
    @request.end_time = range.last
    # current_user
    if @request.save
      mail = RequestMailer.with(request: @request).newRequest
      mail.deliver_now
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def calendar
    respond_to do |format|
      format.text {  render partial: 'requests/mycalendar', locals: { requests: [@request] }, formats: [:html] }
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:request_type, :start_time, :end_time, :origin, :destination, :available, :user_id)
  end
end
