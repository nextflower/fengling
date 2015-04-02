package com.fengling.core.dao;

import com.fengling.common.hibernate3.Updater;
import com.fengling.core.entity.CmsSiteCompany;

public interface CmsSiteCompanyDao {

	public CmsSiteCompany save(CmsSiteCompany bean);

	public CmsSiteCompany updateByUpdater(Updater<CmsSiteCompany> updater);
}