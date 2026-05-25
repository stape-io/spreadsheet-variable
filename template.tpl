___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Google Sheets Reader",
  "description": "Read data from Google Sheets",
  "categories": [
    "ANALYTICS",
    "CONVERSIONS"
  ],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "type",
    "displayName": "Type",
    "radioItems": [
      {
        "value": "cell",
        "displayValue": "Read Cell",
        "subParams": [],
        "help": "Returns the value of a Google Sheet cell."
      },
      {
        "value": "range",
        "subParams": [],
        "displayValue": "Read Range",
        "help": "Returns arrays of a Google Sheet cell range."
      },
      {
        "value": "object",
        "displayValue": "Read Two Columns",
        "help": "In the \u003ci\u003eRange\u003c/i\u003e field add a range that includes two columns. \n\u003cbr/\u003e\nThe variable returns an object that consists of these two columns.\n\u003cbr/\u003e\nThe first column will be used as the object keys/properties, and the second column will be used as a their values."
      }
    ],
    "simpleValueType": true,
    "defaultValue": "cell"
  },
  {
    "type": "TEXT",
    "name": "sheetName",
    "displayName": "Sheet Name",
    "simpleValueType": true,
    "help": "Enter the name of the Sheet you want to interact with.\u003cbr/\u003e\nIf none is specified, then it will interact with the first visible Sheet in the Spreadsheet.\n\u003cbr/\u003e\u003cbr/\u003e\nAlternatively, you can specify the Sheet Name in the \u003ci\u003eRange\u003c/i\u003e or \u003ci\u003eCell\u003c/i\u003e fields below using A1 Notation. \u003ca href\u003d\"https://developers.google.com/workspace/sheets/api/guides/concepts#cell\"\u003eLearn more\u003c/a\u003e.",
    "valueHint": "Sheet2"
  },
  {
    "type": "TEXT",
    "name": "cell",
    "displayName": "Cell",
    "simpleValueType": true,
    "defaultValue": "A1",
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "cell",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Specify the \u003ci\u003eCell\u003c/i\u003e using A1 Notation. \u003cbr/\u003e\u003cbr/\u003e You can specify the Sheet Name in the \u003ci\u003eSheet Name\u003c/i\u003e field above (preferred), or here using A1 notation. \u003ca href\u003d\"https://developers.google.com/workspace/sheets/api/guides/concepts#cell\"\u003eLearn more\u003c/a\u003e. \u003cbr/\u003e If none is specified, then it will interact with the first visible Sheet in the Spreadsheet."
  },
  {
    "type": "TEXT",
    "name": "range",
    "displayName": "Range",
    "simpleValueType": true,
    "defaultValue": "A1:C1",
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "range",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "object",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Specify the \u003ci\u003eRange\u003c/i\u003e using A1 Notation. \u003cbr/\u003e\u003cbr/\u003e You can specify the Sheet Name in the \u003ci\u003eSheet Name\u003c/i\u003e field above (preferred), or here using A1 notation. \u003ca href\u003d\"https://developers.google.com/workspace/sheets/api/guides/concepts#cell\"\u003eLearn more\u003c/a\u003e. \u003cbr/\u003e If none is specified, then it will interact with the first visible Sheet in the Spreadsheet."
  },
  {
    "type": "TEXT",
    "name": "url",
    "displayName": "Spreadsheet URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "https://docs.google.com/spreadsheets/d/123456789/edit?"
  },
  {
    "type": "GROUP",
    "name": "authGropu",
    "displayName": "Authentication Credentials",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "RADIO",
        "name": "authFlow",
        "displayName": "Type",
        "radioItems": [
          {
            "value": "stape",
            "displayValue": "Stape Google Connection",
            "help": "Learn how to setup Stape Google Sheet Connection \u003ca href\u003d\"https://stape.io/blog/write-data-from-server-google-tag-manager-to-google-sheets#google-sheets-connection\"\u003ehere\u003c/a\u003e."
          },
          {
            "value": "own",
            "displayValue": "Own Google Credentials",
            "help": "It uses the \u003ci\u003eApplication Default Credentials\u003c/i\u003e from GCP to automatically find credentials from the server environment. \u003ca href\u003d\"https://cloud.google.com/docs/authentication/application-default-credentials\"\u003eLearn more\u003c/a\u003e.\n\u003cbr/\u003e\u003cbr/\u003e\n\u003ca href\u003d\"https://stape.io/blog/write-data-from-server-google-tag-manager-to-google-sheets#how-to-set-google-sheets-tag-up-for-non-stape-users\"\u003eLearn how to set it up\u003c/a\u003e."
          }
        ],
        "simpleValueType": true,
        "defaultValue": "stape"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://oauth2.googleapis.com/"
              },
              {
                "type": 1,
                "string": "https://content-sheets.googleapis.com/"
              },
              {
                "type": 1,
                "string": "https://*.stape.io/*"
              },
              {
                "type": 1,
                "string": "https://*.stape.net/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "use_google_credentials",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedScopes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://www.googleapis.com/auth/spreadsheets"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-identifier"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-default-domain"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-api-key"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Sheet Range without Sheet Name is built successfully
  code: |-
    setMockDataByActionType('range');
    Object.delete(mockData, 'sheetName');

    const EXPECTED_SHEET_RANGE = encodeUriComponent(mockData.range);
    mock('sendHttpRequest', (requestUrl, requestOptions, requestBody) => {
      const originalPath = requestUrl.split('originalPath=').pop();
      const range = originalPath.split('/').pop();
      assertThat(range).isEqualTo(EXPECTED_SHEET_RANGE);
      return Promise.create((resolve, reject) => resolve({ statusCode: 200, body: '{}' }));
    });

    runCode(mockData);
- name: '[Cell] Sheet Range with Sheet Name is built successfully'
  code: |-
    setMockDataByActionType('cell');

    const EXPECTED_SHEET_RANGE = "'" + encodeUriComponent(mockData.sheetName) + "'!" + encodeUriComponent(mockData.cell);
    mock('sendHttpRequest', (requestUrl, requestOptions, requestBody) => {
      const originalPath = requestUrl.split('originalPath=').pop();
      const range = originalPath.split('/').pop();
      assertThat(range).isEqualTo(EXPECTED_SHEET_RANGE);
      return Promise.create((resolve, reject) => resolve({ statusCode: 200, body: '{"values":[[]]}' }));
    });

    runCode(mockData);
- name: '[Range] Sheet Range with Sheet Name is built successfully'
  code: |-
    setMockDataByActionType('range');

    const EXPECTED_SHEET_RANGE = "'" + encodeUriComponent(mockData.sheetName) + "'!" + encodeUriComponent(mockData.range);
    mock('sendHttpRequest', (requestUrl, requestOptions, requestBody) => {
      const originalPath = requestUrl.split('originalPath=').pop();
      const range = originalPath.split('/').pop();
      assertThat(range).isEqualTo(EXPECTED_SHEET_RANGE);
      return Promise.create((resolve, reject) => resolve({ statusCode: 200, body: '{}' }));
    });

    runCode(mockData);
- name: '[Two Columns] Sheet Range with Sheet Name is built successfully'
  code: |-
    setMockDataByActionType('object');

    const EXPECTED_SHEET_RANGE = "'" + encodeUriComponent(mockData.sheetName) + "'!" + encodeUriComponent(mockData.range);
    mock('sendHttpRequest', (requestUrl, requestOptions, requestBody) => {
      const originalPath = requestUrl.split('originalPath=').pop();
      const range = originalPath.split('/').pop();
      assertThat(range).isEqualTo(EXPECTED_SHEET_RANGE);
      return Promise.create((resolve, reject) => resolve({ statusCode: 200, body: '{"values":[[]]}' }));
    });

    runCode(mockData);
- name: '[Stape Google Connection] Read Cell request is built and sent successfully'
  code: "setMockDataByActionType('cell');\n\nmock('sendHttpRequest', (requestUrl,\
    \ requestOptions, requestBody) => {\n  assertThat(requestUrl).isEqualTo(\"https://expectedXGtmIdentifier.expectedXGtmDefaultDomain/stape-api/expectedXGtmApiKey/v2/spreadsheet?originalPath=/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!A1\"\
    );\n  \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type': 'application/json'\
    \ }, method: 'GET' });\n  \n  return Promise.create((resolve, reject) => resolve({\
    \ statusCode: 200,  body: '{\"values\":[[\"foobar\"]]}' }));\n});\n\nrunCode(mockData).then((variableResult)\
    \ => {\n  assertThat(variableResult).isEqualTo('foobar');\n});"
- name: '[Stape Google Connection] Read Range request is built and sent successfully'
  code: "setMockDataByActionType('range');\n\nmock('sendHttpRequest', (requestUrl,\
    \ requestOptions, requestBody) => {\n    assertThat(requestUrl).isEqualTo(\"https://expectedXGtmIdentifier.expectedXGtmDefaultDomain/stape-api/expectedXGtmApiKey/v2/spreadsheet?originalPath=/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!C1%3AD1\"\
    );\n  \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type': 'application/json'\
    \ }, method: 'GET' });\n  \n  return Promise.create((resolve, reject) => resolve({\
    \ statusCode: 200,  body: '{\"values\":[[\"foo\",\"bar\"]]}' }));\n});\n\nrunCode(mockData).then((variableResult)\
    \ => {\n  assertThat(variableResult).isEqualTo([['foo', 'bar']]);\n});"
- name: '[Stape Google Connection] Read Two Columns request is built and sent successfully'
  code: "setMockDataByActionType('object');\n\nmock('sendHttpRequest', (requestUrl,\
    \ requestOptions, requestBody) => {\n  assertThat(requestUrl).isEqualTo(\"https://expectedXGtmIdentifier.expectedXGtmDefaultDomain/stape-api/expectedXGtmApiKey/v2/spreadsheet?originalPath=/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!C%3AD\"\
    );\n  \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type': 'application/json'\
    \ }, method: 'GET' });\n  \n  return Promise.create((resolve, reject) => resolve({\
    \ statusCode: 200,  body: '{\"values\":[[\"foo\",\"bar\"]]}' }));\n});\n\nrunCode(mockData).then((variableResult)\
    \ => {\n  assertThat(variableResult).isEqualTo({ foo: 'bar' });\n});"
- name: '[Own Google Credentials] Read Cell request is built and sent successfully'
  code: "setMockDataByActionType('cell', {\n  authFlow: 'own'\n});\n\nmock('sendHttpRequest',\
    \ (requestUrl, requestOptions, requestBody) => {\n  assertThat(requestUrl).isEqualTo(\"\
    https://content-sheets.googleapis.com/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!A1\"\
    );\n  \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type': 'application/json'\
    \ }, authorization: 'mockedGoogleAuth', method: 'GET' });\n  \n  return Promise.create((resolve,\
    \ reject) => resolve({ statusCode: 200,  body: '{\"values\":[[\"foobar\"]]}' }));\n\
    });\n\nrunCode(mockData).then((variableResult) => {\n  assertThat(variableResult).isEqualTo('foobar');\n\
    });"
- name: '[Own Google Credentials] Read Range request is built and sent successfully'
  code: "setMockDataByActionType('range', {\n  authFlow: 'own'\n});\n\nmock('sendHttpRequest',\
    \ (requestUrl, requestOptions, requestBody) => {\n  assertThat(requestUrl).isEqualTo(\"\
    https://content-sheets.googleapis.com/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!C1%3AD1\"\
    );\n    \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type':\
    \ 'application/json' }, authorization: 'mockedGoogleAuth', method: 'GET' });\n\
    \  \n  return Promise.create((resolve, reject) => resolve({ statusCode: 200, \
    \ body: '{\"values\":[[\"foo\",\"bar\"]]}' }));\n});\n\nrunCode(mockData).then((variableResult)\
    \ => {\n  assertThat(variableResult).isEqualTo([['foo', 'bar']]);\n});"
- name: '[Own Google Credentials] Read Two Columns request is built and sent successfully'
  code: "setMockDataByActionType('object', {\n  authFlow: 'own'\n});\n\nmock('sendHttpRequest',\
    \ (requestUrl, requestOptions, requestBody) => {\n  assertThat(requestUrl).isEqualTo(\"\
    https://content-sheets.googleapis.com/v4/spreadsheets/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/values/'Sheet2'!C%3AD\"\
    );\n    \n  assertThat(requestOptions).isEqualTo({ headers: { 'Content-Type':\
    \ 'application/json' }, authorization: 'mockedGoogleAuth', method: 'GET' });\n\
    \  \n  return Promise.create((resolve, reject) => resolve({ statusCode: 200, \
    \ body: '{\"values\":[[\"foo\",\"bar\"]]}' }));\n});\n\nrunCode(mockData).then((variableResult)\
    \ => {\n  assertThat(variableResult).isEqualTo({ foo: 'bar' });\n});"
- name: gtmOnFailure is called if request fails (statusCode)
  code: |-
    setMockDataByActionType('cell');

    mock('sendHttpRequest', (requestUrl, requestOptions, requestBody) => {
      return Promise.create((resolve, reject) => resolve({ statusCode: 500, body: '{}' }));
    });

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isString().isEmpty();
    });
setup: "const Promise = require('Promise');\nconst JSON = require('JSON');\nconst\
  \ makeInteger = require('makeInteger');\nconst Object = require('Object');\nconst\
  \ callLater = require('callLater');\nconst parseUrl = require('parseUrl');\nconst\
  \ encodeUriComponent = require('encodeUriComponent');\n\nconst mergeObj = (target,\
  \ source) => {\n  for (const key in source) {\n    if (source.hasOwnProperty(key))\
  \ target[key] = source[key];\n  }\n  return target;\n};\n\nconst mockData = {};\n\
  \nconst setMockDataByActionType = (actionType, objToBeMerged) => {\n  const actionTypes\
  \ = {\n    cell: {\n      type: 'cell',\n      sheetName: 'Sheet2',\n      cell:\
  \ 'A1',\n      url: 'https://docs.google.com/spreadsheets/d/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/edit?gid=159292600#gid=159292600',\n\
  \      authFlow: 'stape'\n    },\n    range: {\n      type: 'range',\n      sheetName:\
  \ 'Sheet2',\n      range: 'C1:D1',\n      url: 'https://docs.google.com/spreadsheets/d/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/edit?gid=159292600#gid=159292600',\n\
  \      authFlow: 'stape'\n    },\n    object: {\n      type: 'object',\n      sheetName:\
  \ 'Sheet2',\n      range: 'C:D',\n      url: 'https://docs.google.com/spreadsheets/d/1VSbWfu1nrVUinb2kXHX9Gy599sBtue5wnaHFO8W4BS8/edit?gid=159292600#gid=159292600',\n\
  \      authFlow: 'stape'\n    }\n  };\n  \n  return mergeObj(\n    mockData, \n\
  \    mergeObj(actionTypes[actionType], objToBeMerged)\n  );\n};\n\nmock('sendHttpRequest',\
  \ (requestUrl, callback, requestOptions, requestBody) => {\n  return Promise.create((resolve,\
  \ reject) => {\n    resolve({ statusCode: 200, body: '{}' });\n  });  \n});\n\n\
  mock('getRequestHeader', (header) => {\n  if (header === 'trace-id') return 'expectedTraceId';\n\
  \  else if (header === 'x-gtm-identifier') return 'expectedXGtmIdentifier';\n  else\
  \ if (header === 'x-gtm-default-domain') return 'expectedXGtmDefaultDomain';\n \
  \ else if (header === 'x-gtm-api-key') return 'expectedXGtmApiKey';\n});\n\nmock('getGoogleAuth',\
  \ () => {\n  return 'mockedGoogleAuth';\n});"


___NOTES___

2026-05-25 - Change Notes:
  - Update Stape Proxy endpoint to v2.

Created on 04/04/2022, 15:59:37

