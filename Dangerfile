# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"
warn("PR is tested with danger")
# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("This Pull Request is quite big, more than 500 lines of changes.") if git.lines_of_code > 500

# XCODE SUMMARY
xcode_summary.ignored_files = 'Pods/**'
xcode_summary.inline_mode = true
xcode_summary.report 'result/WeatherTestResult.xcresult'

# XCOV
# Generate report
xcov_report = xcov.produce_report(
    scheme: 'WeatherToday',
    workspace: 'WeatherToday.xcworkspace',
    exclude_targets: 'WeatherToday',
    minimum_coverage_percentage: 10.0,
    output_directory: 'xcov_report',
    markdown_report: true,
    html_report: false,
    derived_data_path: '.output'
)

# Post markdown report
xcov.output_report(xcov_report)