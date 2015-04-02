package com.fengling.core.manager;

import java.util.Map;

import com.fengling.common.email.EmailSender;
import com.fengling.common.email.MessageTemplate;
import com.fengling.core.entity.Config;
import com.fengling.core.entity.Config.ConfigLogin;

public interface ConfigMng {
	public Map<String, String> getMap();

	public ConfigLogin getConfigLogin();

	public EmailSender getEmailSender();

	public MessageTemplate getForgotPasswordMessageTemplate();
	
	public MessageTemplate getRegisterMessageTemplate();

	public String getValue(String id);

	public void updateOrSave(Map<String, String> map);

	public Config updateOrSave(String key, String value);

	public Config deleteById(String id);

	public Config[] deleteByIds(String[] ids);
}