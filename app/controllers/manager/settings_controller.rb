class Manager::SettingsController < Manager::AuthorizedBaseController
  before_action :get_setting, only: [:edit, :update]

  def index
    @settings = Setting.get_all
    @email_settings = Setting.get_all('email')
  end

  def edit
    @field_name = params[:id]
    @field_type = params[:field_type]
    @field_value = Setting[@field_name]
  end

  def update
    @field_name = params[:id]

    Setting[@field_name] = params[:setting][:value]
    notice = "Setting value has been updated"
    @field_value = Setting[@field_name]

    respond_to do |format|
      format.html { redirect_to admin_settings_path, notice: notice }
      format.js
    end

  end

  def get_setting
    @setting = Setting["#{params[:id]}"] || Setting.new(var: params[:id])
  end
end
