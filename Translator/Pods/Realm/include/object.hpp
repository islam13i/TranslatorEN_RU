////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#ifndef REALM_OS_OBJECT_HPP
#define REALM_OS_OBJECT_HPP

#include "impl/collection_notifier.hpp"

#include <realm/row.hpp>

namespace realm {
class ObjectSchema;
struct Property;
using RowExpr = BasicRowExpr<Table>;

namespace _impl {
    class ObjectNotifier;
}

enum class CreatePolicy : int8_t {
    // Do not create objects if given something that could be converted to a
    // Realm object but isn't. Used for things like find().
    Skip,
    // Throw an exception if an object with the same PK already exists.
    ForceCreate,
    // If an object with the same PK already exists, set all fields in the input.
    UpdateAll,
    // If an object with the same PK already exists, only set fields which have changed.
    UpdateModified
};

class Object {
public:
    Object();
    Object(std::shared_ptr<Realm> r, ObjectSchema const& s, RowExpr const& o);
    Object(std::shared_ptr<Realm> r, StringData object_type, size_t ndx);

    Object(Object const&);
    Object(Object&&);
    Object& operator=(Object const&);
    Object& operator=(Object&&);

    ~Object();

    std::shared_ptr<Realm> const& realm() const { return m_realm; }
    ObjectSchema const& get_object_schema() const { return *m_object_schema; }
    RowExpr row() const { return m_row; }

    bool is_valid() const { return m_row.is_attached(); }

    NotificationToken add_notification_callback(CollectionChangeCallback callback) &;

    void ensure_user_in_everyone_role();
    void ensure_private_role_exists_for_user();

    // The following functions require an accessor context which converts from
    // the binding's native data types to the core data types. See CppContext
    // for a reference implementation of such a context.
    //
    // The actual definitions of these templated functions is in object_accessor.hpp

    // property getter/setter
    template<typename ValueType, typename ContextType>
    void set_property_value(ContextType& ctx, StringData prop_name,
                            ValueType value, CreatePolicy policy = CreatePolicy::ForceCreate);

    template<typename ValueType, typename ContextType>
    ValueType get_property_value(ContextType& ctx, StringData prop_name);

    template<typename ValueType, typename ContextType>
    ValueType get_property_value(ContextType& ctx, const Property& property);

    // create an Object from a native representation
    template<typename ValueType, typename ContextType>
    static Object create(ContextType& ctx, std::shared_ptr<Realm> const& realm,
                         const ObjectSchema &object_schema, ValueType value,
                         CreatePolicy policy = CreatePolicy::ForceCreate,
                         size_t current_row = size_t(-1), Row* = nullptr);

    template<typename ValueType, typename ContextType>
    static Object create(ContextType& ctx, std::shared_ptr<Realm> const& realm,
                         StringData object_type, ValueType value,
                         CreatePolicy policy = CreatePolicy::ForceCreate,
                         size_t current_row = size_t(-1), Row* = nullptr);

    template<typename ValueType, typename ContextType>
    static Object get_for_primary_key(ContextType& ctx,
                                      std::shared_ptr<Realm> const& realm,
                                      const ObjectSchema &object_schema,
                                      ValueType primary_value);

    template<typename ValueType, typename ContextType>
    static Object get_for_primary_key(ContextType& ctx,
                                      std::shared_ptr<Realm> const& realm,
                                      StringData object_type,
                                      ValueType primary_value);

private:
    friend class Results;

    std::shared_ptr<Realm> m_realm;
    const ObjectSchema *m_object_schema;
    Row m_row;
    _impl::CollectionNotifier::Handle<_impl::ObjectNotifier> m_notifier;


    template<typename ValueType, typename ContextType>
    void set_property_value_impl(ContextType& ctx, const Property &property,
                                 ValueType value, CreatePolicy policy, bool is_default);
    template<typename ValueType, typename ContextType>
    ValueType get_property_value_impl(ContextType& ctx, const Property &property);

    template<typename ValueType, typename ContextType>
    static size_t get_for_primary_key_impl(ContextType& ctx, Table const& table,
                                           const Property &primary_prop, ValueType primary_value);

    void verify_attached() const;
    Property const& property_for_name(StringData prop_name) const;
};

struct InvalidatedObjectException : public std::logic_error {
    InvalidatedObjectException(const std::string& object_type);
    const std::string object_type;
};

struct InvalidPropertyException : public std::logic_error {
    InvalidPropertyException(const std::string& object_type, const std::string& property_name);
    const std::string object_type;
    const std::string property_name;
};

struct MissingPropertyValueException : public std::logic_error {
    MissingPropertyValueException(const std::string& object_type, const std::string& property_name);
    const std::string object_type;
    const std::string property_name;
};

struct MissingPrimaryKeyException : public std::logic_error {
    MissingPrimaryKeyException(const std::string& object_type);
    const std::string object_type;
};

struct ReadOnlyPropertyException : public std::logic_error {
    ReadOnlyPropertyException(const std::string& object_type, const std::string& property_name);
    const std::string object_type;
    const std::string property_name;
};

struct ModifyPrimaryKeyException : public std::logic_error {
    ModifyPrimaryKeyException(const std::string& object_type, const std::string& property_name);
    const std::string object_type;
    const std::string property_name;
};

} // namespace realm

#endif // REALM_OS_OBJECT_HPP
