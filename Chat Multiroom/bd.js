
var conString = "postgres://kaique_sm:huehuehue@localhost/chat";

module.exports = 
{

  //Nao esquecer de passar o res.json()
  getMessages: function (pg, idPista, callback) {

    var client = new pg.Client(conString);
    client.connect(function(err) {
      if(err) {
        return console.error('could not connect to postgres', err);
      }
      client.query("SELECT * FROM chat WHERE pista = $1", [idPista], function(err, result) {
        if(err) {
          return console.error('error running query', err);
        }
        callback(result.rows);
        client.end();
      });
    });

  },

  putMessage: function(pg, infos, callback) {

    var client = new pg.Client(conString);
    client.connect(function(err) {
      if(err) {
        return console.error('could not connect to postgres', err);
      }
    var queryText = 'INSERT INTO chat(texto, usuario, pista) VALUES($1, $2, $3) RETURNING id'
      client.query(queryText, [infos.message, infos.username, infos.pista], function(err, result) {
        if(err) {
          return console.error('error running query', err);
        }
        callback(result.rows[0].id);
        client.end();
      });
    });
  },



};


// CREATE TABLE IF NOT EXISTS chat (
//   id SERIAL PRIMARY KEY,
//   texto TEXT,
//   usuario TEXT,
//   pista INTEGER

// );