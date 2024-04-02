class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  skip_after_action :verify_policy_scoped, only: %i[show new create edit update destroy]

  def index
    @videos = policy_scope(Video).includes(:organisation).order(created_at: :desc)
    authorize Video
  end

  def new
    @video = current_user.organisation.videos.build
    authorize @video
  end

  def create
    @video = current_user.organisation.videos.build(video_params.merge(user: current_user))
    authorize @video

    if @video.file? && @video.save
      TranscodeVideoJob.perform_later(video_id: @video.id)
      redirect_to @video, notice: 'Video was successfully created and is being processed.'
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error_explanation', partial: 'videos/errors', locals: { video: @video }) }
        format.html { render :new }
      end
    end
  end

  def show
    @video_path = VideoRetriever.call(@video)
    authorize @video
  end

  def edit
    authorize @video
  end

  def update
    authorize @video
    if @video.update(video_params)
      redirect_to @video, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @video
    @video.destroy
    redirect_to videos_url, notice: 'Video was successfully destroyed.'
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:file, :title, :description, :thumbnail, :overlay, :user_id, category_ids: [])
  end
end
