import mariadb from "mariadb";

const pool = mariadb.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  connectionLimit: 10,
});

async function executeQuery(sql: string, values?: any): Promise<any> {
  const connection = await pool.getConnection();
  const data = connection.query(sql, values);
  connection.end();
  return data;
}

export { executeQuery };
