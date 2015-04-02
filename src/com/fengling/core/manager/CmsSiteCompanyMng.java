package com.fengling.core.manager;

import com.fengling.core.entity.CmsSite;
import com.fengling.core.entity.CmsSiteCompany;

public interface CmsSiteCompanyMng {
	public CmsSiteCompany save(CmsSite site,CmsSiteCompany bean);

	public CmsSiteCompany update(CmsSiteCompany bean);
}