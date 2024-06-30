use hello;

#[test]
fn check_value1() {
    let val = hello::make_string("hello", "world");
    assert_eq!(val, String::from("hello world"));
}

#[test]
fn check_value2() {
    let val = hello::make_string("world", "hello");
    assert_eq!(val, String::from("world hello"));
}

#[test]
fn check_value3() {
    let val = hello::make_string("hello", "hello");
    assert_eq!(val, String::from("hello hello"));
}

#[test]
fn check_value4() {
    let val = hello::make_string("hello", "hello");
    assert_eq!(val, String::from("hello1 hello2"));
}
