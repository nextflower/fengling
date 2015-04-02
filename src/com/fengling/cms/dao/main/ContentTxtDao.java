package com.fengling.cms.dao.main;

import com.fengling.cms.entity.main.ContentTxt;
import com.fengling.common.hibernate3.Updater;

public interface ContentTxtDao {
	public ContentTxt findById(Integer id);

	public ContentTxt save(ContentTxt bean);

	public ContentTxt updateByUpdater(Updater<ContentTxt> updater);
}