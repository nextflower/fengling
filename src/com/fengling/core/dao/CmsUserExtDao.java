package com.fengling.core.dao;

import com.fengling.common.hibernate3.Updater;
import com.fengling.core.entity.CmsUserExt;

public interface CmsUserExtDao {
	public CmsUserExt findById(Integer id);

	public CmsUserExt save(CmsUserExt bean);

	public CmsUserExt updateByUpdater(Updater<CmsUserExt> updater);
}