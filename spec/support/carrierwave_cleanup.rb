module CarrierWaveCleanup
  def clean_uploaded_files
    test_uploads_path_1 = Rails.root.join('public', 'uploads', 'tmp')
    test_uploads_path_2 = Rails.root.join('public', 'uploads', 'video')

    FileUtils.remove_dir(test_uploads_path_1) if File.directory?(test_uploads_path_1)
    FileUtils.remove_dir(test_uploads_path_2) if File.directory?(test_uploads_path_2)
  end
end
