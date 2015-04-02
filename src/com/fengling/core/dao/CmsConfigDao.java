package com.fengling.core.dao;

import com.fengling.common.hibernate3.Updater;
import com.fengling.core.entity.CmsConfig;

public interface CmsConfigDao {
	public CmsConfig findById(Integer id);

	public CmsConfig updateByUpdater(Updater<CmsConfig> updater);
}