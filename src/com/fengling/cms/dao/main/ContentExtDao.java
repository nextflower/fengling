package com.fengling.cms.dao.main;

import com.fengling.cms.entity.main.ContentExt;
import com.fengling.common.hibernate3.Updater;

public interface ContentExtDao {
	public ContentExt findById(Integer id);

	public ContentExt save(ContentExt bean);

	public ContentExt updateByUpdater(Updater<ContentExt> updater);
}