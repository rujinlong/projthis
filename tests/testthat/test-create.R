{ # create a scope for the test file

  # be quiet and leave no footprints
  withr::local_options(list(usethis.quiet = TRUE))
  if (interactive()) usethis::local_project()
  tempdir <- withr::local_tempdir(tmpdir = fs::path(tempdir(), "qproj-create"))

  test_that("proj_create() works", {

    localdir <- fs::path(tempdir, "proj-01")

    # capture output
    expect_no_error(
      proj_create(path = localdir)
    )

    # DESCRIPTION exists
    expect_true(
      fs::file_exists(fs::path(localdir, "DESCRIPTION"))
    )

    # README.md exists
    expect_true(
      fs::file_exists(fs::path(localdir, "README.md"))
    )

    # NAMESPACE exists
    expect_true(
      fs::file_exists(fs::path(localdir, "NAMESPACE"))
    )

    # .gitignore exists
    expect_true(
      fs::file_exists(fs::path(localdir, ".gitignore"))
    )

  })

  test_that("proj_use_workflow() works", {

    localdir <- fs::path(tempdir, "proj-02")
    fs::dir_create(localdir)
    withr::local_dir(localdir)

    expect_no_error(
      proj_use_workflow(path_proj = "analyses")
    )

    expect_true(fs::dir_exists("analyses"))
    expect_true(fs::dir_exists("analyses/data"))
    expect_true(fs::file_exists("analyses/data/README.md"))
    expect_true(fs::file_exists("analyses/README.md"))
    expect_true(fs::file_exists(".gitignore"))

    gitignore_lines <- readLines(".gitignore")
    expect_true("analyses/data/*" %in% gitignore_lines)
    expect_true("!analyses/data/README.md" %in% gitignore_lines)

  })

}




