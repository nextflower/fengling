package com.fengling.cms.dao.main;

import com.fengling.cms.entity.main.ContentCheck;
import com.fengling.common.hibernate3.Updater;

public interface ContentCheckDao {
	public ContentCheck findById(Long id);

	public ContentCheck save(ContentCheck bean);

	public ContentCheck updateByUpdater(Updater<ContentCheck> updater);
}