package com.example.travler;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@SuppressWarnings("unused")
@Configuration
public class DataSourceConfig {
    private static final String DB_NAME = "travler";
    private static final String DB_USER = "postgres";
    private static final String DB_PASS = "postgres";
    private static final String PROJECT = "level-sol-415712";
    private static final String REGION = "europe-central2";
    private static final String INSTANCE = "qwertyuiop";

    @Bean
    public DataSource dataSource() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(String.format("jdbc:postgresql:///%s", DB_NAME));
        config.setUsername(DB_USER);
        config.setPassword(DB_PASS);
        config.addDataSourceProperty(
                "socketFactory",
                "com.google.cloud.sql.postgres.SocketFactory"
        );
        config.addDataSourceProperty(
                "cloudSqlInstance",
                String.format("%s:%s:%S", PROJECT, REGION, INSTANCE)
        );

        return new HikariDataSource(config);
    }
}
