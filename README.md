# Google Sheets Reader Variable for Google Tag Manager Server-Side

The **Google Sheets Reader Variable** for Google Tag Manager Server-Side allows you to read data from a Google Sheet and use it within your server container. This is useful for enriching data, creating lookup tables, or managing settings dynamically.

**The variable supports three action types:**

- **Read Cell**: Fetches the value from a single cell.
- **Read Range**: Fetches all values from a specified range as a two-dimensional array.
- **Read Two Columns**: Fetches data from two adjacent columns and returns it as a key-value object.

### How to use the Google Sheets Reader Variable

1.  Add the **Google Sheets Reader** variable to your server container in GTM.
2.  Select the **Action Type**: `Read Cell`, `Read Range`, or `Read Two Columns`.
3.  Provide the **Spreadsheet URL** of the Google Sheet you want to read from.
4.  (Optional) Provide a **Sheet Name** (e.g., `Sheet1`). If not set, the first visible sheet is used.
5.  Specify the **Cell** or **Range** using A1 notation (e.g. `A1`, `B2:C10`).
6.  Choose your **Authentication** method.
    - **Stape Google Connection** – Uses a simplified setup via Stape's connection. [Learn more](https://stape.io/blog/read-data-from-google-sheet-to-server-google-tag-manager#for-stape-users).
    - **Own Google Credentials** – Uses Application Default Credentials from your GCP environment. [Learn more](https://stape.io/blog/read-data-from-google-sheet-to-server-google-tag-manager#for-non-stape-users).

7.  Use the variable in your tags, triggers, or other variables within the server container.

## Parameters

### Main Configuration
- **Type**: The read operation to perform.
    - **Read Cell**: Returns the value of a single cell as a string.
    - **Read Range**: Returns a range of cells as a 2D array (an array of rows, where each row is an array of cell values).
    - **Read Two Columns**: Takes a two-column range and returns an object, using the first column for keys and the second for values.
- **Spreadsheet URL**: The full URL of the target Google Spreadsheet.
- **Sheet Name**: The name of the specific sheet (tab) to read from. This is optional if the sheet name is included in the Cell/Range parameter.
- **Cell**: (For "Read Cell" type) The cell to read from, using A1 notation (e.g., `B4`).
- **Range**: (For "Read Range" and "Read Two Columns" types) The range of cells to read, using A1 notation (e.g., `A1:D10`).

### Authentication Credentials
- **Auth Type**:
    - **Stape Google Connection**: A simplified authentication method for Stape users. Requires enabling the **Google Sheets Connection** in your container settings.
    - **Own Google Credentials**: Uses Application Default Credentials from a Google Cloud Platform environment. This requires enabling the Google Sheets API on GCP, setting up a service account and granting it access to your Google Sheet.

## Useful resources

- [How to read data from Google Sheets in server Google Tag Manager](https://stape.io/blog/read-data-from-google-sheet-to-server-google-tag-manager)
- [How to set up the Stape Google Connection](https://stape.io/blog/read-data-from-google-sheet-to-server-google-tag-manager#for-stape-users)
- [How to set up the Own Google Credentials](https://stape.io/blog/read-data-from-google-sheet-to-server-google-tag-manager#for-non-stape-users)

## Open Source

The **Google Sheets Reader Variable for GTM Server-Side** is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.