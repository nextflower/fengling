package com.fengling.cms.lucene;

import com.fengling.search.solrmodule.query.EPSSolrServerForCommon;

public interface SolrContentDao {

	public Integer index(EPSSolrServerForCommon server, Integer siteId, Integer channelId);
	
}
