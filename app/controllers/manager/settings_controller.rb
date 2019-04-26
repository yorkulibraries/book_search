class Manager::SettingsController < Manager::AuthorizedBaseController
  before_action :get_setting, only: [:edit, :update]

  def index
    @settings = Setting.get_all
    @email_settings = Setting.get_all('email')
  end

  def edit
    @field_name = params[:id]
    @field_type = params[:field_type]
  end

  def update
    @field_name = params[:id]

    if @setting.value != params[:setting][:value]
      @setting.value = params[:setting][:value]
      @setting.save
      redirect_to admin_settings_path, notice: 'Setting has updated.'
    else
      redirect_to admin_settings_path
    end
  end

  def get_setting
    @setting = Setting["#{params[:id]}"] || Setting.new(var: params[:id])
  end
end
