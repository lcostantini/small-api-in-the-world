Cuba.define do
  begin
    validate_access!

    on 'tasks' do
      run Tasks
    end

  rescue StandardError => e
    on true do
      res.status = 401
      res.write "{ \"errors\": \"#{ e.message }\" }"
    end
  end
end
