express = require('express')
router = express.Router()

### GET home page. ###

router.get '/', (req, res, next) ->
  res.render 'index', title: 'Express'
  return
module.exports = router

# ---
# generated by js2coffee 2.1.0
