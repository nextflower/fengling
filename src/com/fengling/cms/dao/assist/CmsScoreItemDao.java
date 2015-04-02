package com.fengling.cms.dao.assist;

import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;
import com.fengling.cms.entity.assist.CmsScoreItem;

public interface CmsScoreItemDao {
	public Pagination getPage(Integer groupId,int pageNo, int pageSize);

	public CmsScoreItem findById(Integer id);

	public CmsScoreItem save(CmsScoreItem bean);

	public CmsScoreItem updateByUpdater(Updater<CmsScoreItem> updater);

	public CmsScoreItem deleteById(Integer id);
}