const { BigQuery } = require('@google-cloud/bigquery');
const bigquery = new BigQuery();

exports.processJson = async (event, context) => {
  const data = JSON.parse(Buffer.from(event.data, 'base64').toString());
  const bucketName = data.bucket;
  const fileName = data.name;

  const storage = new (require('@google-cloud/storage').Storage)();
  const file = storage.bucket(bucketName).file(fileName);

  const contents = await file.download();
  const jsonContent = JSON.parse(contents[0].toString());

  const rows = Array.isArray(jsonContent) ? jsonContent : [jsonContent];
  await bigquery.dataset(process.env.BQ_DATASET)
                 .table(process.env.BQ_TABLE)
                 .insert(rows);

  console.log(`Inserted ${rows.length} rows from ${fileName}`);
};
