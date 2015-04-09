package com.fengling.cms.lucene;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fengling.cms.entity.main.Content;
import com.fengling.search.solrmodule.query.EPSSolrServerForFengLing;
import com.fengling.search.solrmodule.write.EpsSolrDocument;

@Component
public class SolrContentSvcImpl implements SolrContentSvc {
	
	@Autowired
	private EPSSolrServerForFengLing solrServer;

	public void createIndex(Content c) {
		EpsSolrDocument doc = SolrContent.createDocument(c);
		solrServer.addDocument(doc, false);
	}

	public void deleteIndex(Content c) {
		solrServer.deleteById(String.valueOf(c.getId()));
	}

	public void updateIndex(Content c) {
		deleteIndex(c);
		createIndex(c);
	}

	public void createIndex(Integer siteId, Integer channelId) {
		solrContentDao.index(solrServer, siteId, channelId);
	}
	
	@Autowired
	private SolrContentDao solrContentDao;

}
