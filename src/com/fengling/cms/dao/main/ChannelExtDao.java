package com.fengling.cms.dao.main;

import com.fengling.cms.entity.main.ChannelExt;
import com.fengling.common.hibernate3.Updater;

public interface ChannelExtDao {
	public ChannelExt save(ChannelExt bean);

	public ChannelExt updateByUpdater(Updater<ChannelExt> updater);
}