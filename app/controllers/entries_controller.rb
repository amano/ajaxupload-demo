# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
  def new
    @entry = Entry.new
    @users = User.limit(5).order('id DESC')
  end

  def ajax_upload
    begin
      _store_upload(params[:qqfile])
    rescue
      render :json => { :error => $!.message.to_s }
    else
      render :json => { :success => true }
    end
  end

  private

  # XXX エラー処理周りを修正する
  def _store_upload(file)
    if request.xhr?
      if request.body.length == request.headers['CONTENT_LENGTH'].to_i
        file_data = request.body.read 
        file_name = file
      end
    else
      if file.instance_of?(File)
        file_data = file.read 
        file_name = file.original_filename
      end
    end
    
    raise "upload failure" unless file_data

    tf = Tempfile.new(file_name)
    tf << file_data
    @user = User.new
    @user.avatar = tf
    @user.avatar_file_name = file_name
    @user.save
    tf.close!
  end
end
