const encodeUriComponent = require('encodeUriComponent');
const JSON = require('JSON');
const getGoogleAuth = require('getGoogleAuth');
const getRequestHeader = require('getRequestHeader');
const getType = require('getType');
const makeString = require('makeString');
const sendHttpRequest = require('sendHttpRequest');

/*==============================================================================
==============================================================================*/

return readFromGoogleSheets(data);

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getSpreadsheetId(data) {
  return data.url.replace('https://docs.google.com/spreadsheets/d/', '').split('/')[0];
}

function getSheetRange(data) {
  const sheetName = data.sheetName ? "'" + data.sheetName + "'!" : '';
  const range = data.type === 'cell' ? data.cell : data.range;
  return sheetName + range;
}

function getUrl(data) {
  const spreadsheetId = getSpreadsheetId(data);
  const sheetRange = getSheetRange(data);
  const sheetsPath = '/v4/spreadsheets/' + enc(spreadsheetId) + '/values/' + enc(sheetRange);

  if (data.authFlow === 'stape') {
    const containerIdentifier = getRequestHeader('x-gtm-identifier');
    const defaultDomain = getRequestHeader('x-gtm-default-domain');
    const containerApiKey = getRequestHeader('x-gtm-api-key');

    return (
      'https://' +
      enc(containerIdentifier) +
      '.' +
      enc(defaultDomain) +
      '/stape-api/' +
      enc(containerApiKey) +
      '/v2/spreadsheet?originalPath=' +
      sheetsPath
    );
  }

  return 'https://content-sheets.googleapis.com' + sheetsPath;
}

function readFromGoogleSheets(data) {
  const requestUrl = getUrl(data);
  const options = {
    headers: { 'Content-Type': 'application/json' },
    method: 'GET'
  };

  if (data.authFlow === 'own') {
    const auth = getGoogleAuth({
      scopes: ['https://www.googleapis.com/auth/spreadsheets']
    });
    options.authorization = auth;
  }

  return sendHttpRequest(requestUrl, options).then((result) => {
    const bodyParsed = JSON.parse(result.body);

    if (result.statusCode >= 200 && result.statusCode < 400) {
      if (data.type === 'cell') {
        return bodyParsed.values[0][0];
      }

      if (data.type === 'object') {
        return bodyParsed.values.reduce((acc, curr) => {
          acc[curr[0]] = curr[1];
          return acc;
        }, {});
      }

      return bodyParsed.values;
    } else {
      return '';
    }
  });
}

/*==============================================================================
  Helpers
==============================================================================*/

function enc(data) {
  if (['null', 'undefined'].indexOf(getType(data)) !== -1) data = '';
  return encodeUriComponent(makeString(data));
}
