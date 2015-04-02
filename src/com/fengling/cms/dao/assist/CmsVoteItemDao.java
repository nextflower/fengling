package com.fengling.cms.dao.assist;

import com.fengling.cms.entity.assist.CmsVoteItem;
import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;

public interface CmsVoteItemDao {
	public Pagination getPage(int pageNo, int pageSize);

	public CmsVoteItem findById(Integer id);

	public CmsVoteItem save(CmsVoteItem bean);

	public CmsVoteItem updateByUpdater(Updater<CmsVoteItem> updater);

	public CmsVoteItem deleteById(Integer id);
}