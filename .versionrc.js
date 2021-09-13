module.exports = {
  bumpFiles: [
    {
      filename: "pubspec.yaml",
      updater: require.resolve("standard-version-updater-yaml")
    }
  ]
};