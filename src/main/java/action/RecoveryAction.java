package action;

import com.opensymphony.xwork2.ActionContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 数据恢复action类
 */
public class RecoveryAction extends SuperAction {
    //列出当前所有的备份
    public String listdatabase() {

        return "dblist_success";

    }

}
