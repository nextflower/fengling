package com.fengling.core.dao;

import java.util.List;

import com.fengling.common.hibernate3.Updater;
import com.fengling.core.entity.CmsConfigItem;

public interface CmsConfigItemDao {
	public List<CmsConfigItem> getList(Integer configId,Integer category);

	public CmsConfigItem findById(Integer id);

	public CmsConfigItem save(CmsConfigItem bean);

	public CmsConfigItem updateByUpdater(Updater<CmsConfigItem> updater);

	public CmsConfigItem deleteById(Integer id);
}