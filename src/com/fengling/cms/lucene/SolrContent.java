package com.fengling.cms.lucene;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fengling.cms.entity.main.Channel;
import com.fengling.cms.entity.main.Content;
import com.fengling.core.entity.CmsSite;
import com.fengling.search.solrmodule.write.EpsSolrDocument;

public class SolrContent {
	
	public static final String PARAM_ID = "ID";//主键
	public static final String PARAM_CHANNEL_ID = "CHANNEL_ID";//栏目ID
	public static final String PARAM_SITE_ID = "SITE_ID";//站点ID
	public static final String PARAM_TITLE = "TITLE";//标题
	public static final String PARAM_CONTENT = "CONTENT";//正文
	public static final String PARAM_RELEASE_DATE = "RELEASE_DATE";//发布日期
	public static final String PARAM_RELEASE_YEAR = "RELEASE_YEAR";//发布年份
	public static final String PARAM_RELEASE_MONTH = "RELEASE_MONTH";//发布月份

	public static EpsSolrDocument createDocument(Content c) {
		Channel channel = c.getChannel();
		CmsSite site = c.getSite();
		EpsSolrDocument doc = new EpsSolrDocument();
		doc.addField(PARAM_ID, c.getId());
		
		//将所有的父类栏目都写入到同一个字段中
		while(channel != null) {
			doc.addField(PARAM_CHANNEL_ID, channel.getId());
			channel = channel.getParent();
		}
		
		doc.addField(PARAM_SITE_ID, site.getId());
		doc.addField(PARAM_TITLE, c.getTitle());
		doc.addField(PARAM_CONTENT, c.getTxt());
		
		Date releaseDate = c.getReleaseDate();
		doc.addField(PARAM_RELEASE_DATE, c.getReleaseDate());
		doc.addField(PARAM_RELEASE_YEAR, getDateYear(releaseDate));
		doc.addField(PARAM_RELEASE_MONTH, getDateMonth(releaseDate));
		
		
		return doc;
	}
	
	public static String getDateMonth(Date d) {
		DateFormat format = new SimpleDateFormat("yyyyMM");
		return format.format(d);
	}
	
	public static String getDateYear(Date d) {
		DateFormat format = new SimpleDateFormat("yyyy");
		return format.format(d);
	}

}