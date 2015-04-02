package com.fengling.cms.dao.main;

import com.fengling.cms.entity.main.ChannelTxt;
import com.fengling.common.hibernate3.Updater;

public interface ChannelTxtDao {
	public ChannelTxt findById(Integer id);

	public ChannelTxt save(ChannelTxt bean);

	public ChannelTxt updateByUpdater(Updater<ChannelTxt> updater);
}